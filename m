Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSLAUef>; Sun, 1 Dec 2002 15:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSLAUef>; Sun, 1 Dec 2002 15:34:35 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:7558 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S262416AbSLAUee>; Sun, 1 Dec 2002 15:34:34 -0500
To: "Folkert van Heusden" <folkert@vanheusden.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20] alpha (alcor) failing during boot: NCR53c810/NCR53c875 give error "Cache test failed"
References: <002e01c29976$71c12830$3640a8c0@boemboem>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 01 Dec 2002 21:40:12 +0100
Message-ID: <wrplm39scb7.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <002e01c29976$71c12830$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "FvH" == Folkert van Heusden <folkert@vanheusden.com> writes:

FvH> My Dec Alpha (Alcor) runs fine with 2.2.20.
FvH> With 2.4.20, it fails during boot at the init. of the scsi-devices.
FvH> Error is:

[...]

Please give 2.4.20-ac1 a try. It includes the CIA-1 fix that prevent
Alcor machines (AS500 and co) from working.

        M.
-- 
Places change, faces change. Life is so very strange.
