Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbUKQEdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUKQEdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUKQEdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:33:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:24037 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262206AbUKQEdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:33:37 -0500
From: =?iso-8859-15?q?J=F6rg_Spilker?= <js@jetsys.de>
Organization: JetSys
To: Avi Kivity <avi@argo.co.il>
Subject: Re: Apple Ipod doesn't work with USB on linux (but works with FireWire)
Date: Wed, 17 Nov 2004 05:34:24 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
References: <200411071004.15605.js@jetsys.de> <418DF54C.5040803@argo.co.il>
In-Reply-To: <418DF54C.5040803@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411170534.25659.js@jetsys.de>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.28.0.12; VDF: 6.28.0.76; host: daolin)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6a16b48ab260b2defb04d898181c7cb6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 7. November 2004 11:13 schrieb Avi Kivity:

Hi Avi,

> I recently posted a patch which fixes the problem; see attached.

thanks for the patch. I will try it. According to another tip i disabled EFI 
GUID partition support and activated USB debugging. The Ipod is working 
without problems with this config. I'll now try only the GUID support 
disabled but again deactivating USB debugging. I will also try your patch. 

Greetings, Joerg
