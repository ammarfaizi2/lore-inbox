Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRBVPOt>; Thu, 22 Feb 2001 10:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129537AbRBVPOk>; Thu, 22 Feb 2001 10:14:40 -0500
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:28881 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S129156AbRBVPOZ>; Thu, 22 Feb 2001 10:14:25 -0500
Date: Thu, 22 Feb 2001 16:14:23 +0100 (MET)
From: Michael Peter <mp19@mail.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: watchdog implemention
Message-ID: <Pine.GSO.4.10.10102221610560.11223-100000@irz601.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

is there any documentation , how the software watchdog is implemented ?
I'm particularly interested in programming the IO-APIC. What do I have
to do that the PIT gets rerouted so that it triggers an NMI.

Thanks in advance.

Michael Peter

