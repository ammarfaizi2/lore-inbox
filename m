Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293162AbSCOTUo>; Fri, 15 Mar 2002 14:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSCOTUf>; Fri, 15 Mar 2002 14:20:35 -0500
Received: from relay1.soft.net ([164.164.128.17]:21923 "EHLO cyclops.soft.net")
	by vger.kernel.org with ESMTP id <S293175AbSCOTUW>;
	Fri, 15 Mar 2002 14:20:22 -0500
Reply-To: <abdij.bhat@kshema.com>
From: "Abdij Bhat" <abdij.bhat@kshema.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel Level DHCP Versus udhcp
Date: Fri, 15 Mar 2002 19:22:08 -0000
Message-ID: <001c01c1cc56$b38a3ec0$8134aa88@cam.pace.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am deploying a Linux Network Stack. I am supposed to use a stable, fully
featured, RFC compliant, small memory foot-print DHCP client for an embedded
system. We had converged on udhcp for the client. But I have found that
there is a DCHP client implemented in the Linux Kernel ( Version 2.2.x or
later ). This I believe can be configured by choosing the "Kernel level
autoconfiguration".
 I have however practically no documentation on the Kernel DHCP Client. I do
not know how buggy it is, is it a fully featured DHCP client or is it just a
boot level DHCP client used for remote booting etc.
 Can some body help me with this. I believe it is used only for the remote
booting, with the documentation currently available to me. How correct am I?
Can I replace the udhcp client with this one? How much of a change will I
need to do for the replacement?
 I am totally confused....
 Please help...
Thanks and regards,
Abdij






