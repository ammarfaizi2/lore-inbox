Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTEWIZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbTEWIZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:25:22 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:59334 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263930AbTEWIZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:25:21 -0400
Subject: [PATCH] Fix warning with ndelay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Paul Mackerras <paulus@samba.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053679084.1160.99.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2003 10:38:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
