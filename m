Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261408AbREMPJu>; Sun, 13 May 2001 11:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbREMPJk>; Sun, 13 May 2001 11:09:40 -0400
Received: from equinox.unr.edu ([134.197.1.2]:54741 "EHLO equinox.unr.edu")
	by vger.kernel.org with ESMTP id <S261408AbREMPJ0>;
	Sun, 13 May 2001 11:09:26 -0400
From: Eric Olson <ejolson@unr.edu>
Message-Id: <200105131509.f4DF9DA06907@equinox.unr.edu>
Subject: Re: FastTrack100+2.4.4 panic
To: ehrhardt@mathematik.uni-ulm.de (Christian Ehrhardt)
Date: Sun, 13 May 2001 08:09:13 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, Axel.Thimm@physik.fu-berlin.de
In-Reply-To: <20010513132716.12063.qmail@theseus.mathematik.uni-ulm.de> from "Christian Ehrhardt" at May 13, 2001 03:27:16 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks both Christian Ehrhardt and Axel Thimm!  The two-line patch 
to drivers/ide/ide-pci.c (including comment) worked perfectly.  

--Eric
