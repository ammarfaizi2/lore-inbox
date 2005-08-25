Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVHYKjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVHYKjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 06:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVHYKjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 06:39:42 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:23437 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S964930AbVHYKjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 06:39:41 -0400
Date: Thu, 25 Aug 2005 16:10:40 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: starting function of keyboard.c in FC2.
Message-ID: <Pine.LNX.4.60.0508251606170.16200@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai,
    In RH9 the starting function of keyboard.c is handle_scancode, this is 
the function to which the scancode is given by the keyboard interrupt 
handler, its fine, but in FC2 , this handle_scancode is not there, it's 
functionality is spitted and placed in several functions. What is the 
starting function of keyboard.c in FC2?
if anybody knows please suggest on it.

Thanks & Regards,
P.Manohar.
