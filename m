Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUEAPnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUEAPnt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 11:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUEAPns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 11:43:48 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:27915 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S262238AbUEAPns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 11:43:48 -0400
Message-ID: <4093C5B8.5040806@mauve.plus.com>
Date: Sat, 01 May 2004 16:43:52 +0100
From: Ian Stirling <linux-kernel@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Debugging [binary] modules.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any tool that logs every access of a module to anything?
Every memory or IO access, all calls, ...
Ideally without requiring any alterations to the module binary, for the
case when source isn't available.
