Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTGPOni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270891AbTGPOnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:43:37 -0400
Received: from [157.193.204.1] ([157.193.204.1]:4573 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S270859AbTGPOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:43:36 -0400
Subject: __put_task_struct
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 16 Jul 2003 16:58:15 +0200
Message-Id: <1058367495.1073.10.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When using get/put_task_struct from inside a module, kbuild warns about
__put_task_struct being undefined. Can someone export this function?

Frank.

