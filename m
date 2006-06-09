Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWFIJTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWFIJTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWFIJTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:19:04 -0400
Received: from vvv.conterra.de ([212.124.44.162]:58307 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S932117AbWFIJTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 05:19:03 -0400
Message-ID: <44893D00.8090807@conterra.de>
Date: Fri, 09 Jun 2006 11:18:56 +0200
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mixing 32 and 64 bit?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wonder how some userland applications are able to use 64-bit 
capabilities although they are started by an  ELF 32-bit binary. I observed
this when installing vmware: Even if the binary is an ELF32, it is
able to provide an 64Bit ABI to its guest OS. Until now I thought a
process is either 32bit or 64bit. Seems this is not true. 

Has some one a good link or entry point about this topic?
I could not find a matching keyword to search for. 

Regards, Dieter.
