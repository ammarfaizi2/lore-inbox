Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266356AbUAHWyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUAHWyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:54:36 -0500
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:35010 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S266356AbUAHWyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:54:35 -0500
Message-ID: <3FFDDE33.1070006@chartermi.net>
Date: Thu, 08 Jan 2004 17:48:19 -0500
From: Nathaniel M Nelson <nmn@chartermi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible weird TCP/IP bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 3 machines running 2.4.22 (Slackware 9.1) and only one of them, 
which happens to be my firewall, sends out TCP sequence numbers starting 
with "0".  This does not seem right to me.  If this is not a bug, I 
apoligize...if anyone thinks it might be, please tell me if you need 
more in-depth info.
