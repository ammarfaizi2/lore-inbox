Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130581AbRBQUGM>; Sat, 17 Feb 2001 15:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131443AbRBQUFw>; Sat, 17 Feb 2001 15:05:52 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:46091 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S130581AbRBQUFl>; Sat, 17 Feb 2001 15:05:41 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200102171949.NAA16986@isunix.it.ilstu.edu>
Subject: Re: SMP: bind process to cpu
To: thomas.widmann@icn.siemens.de (Thomas Widmann)
Date: Sat, 17 Feb 2001 13:49:41 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BGEDIODHBENLENEMBEPAEEDFCAAA.thomas.widmann@icn.siemens.de> from "Thomas Widmann" at Feb 17, 2001 01:36:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to bind a process to a specific
> cpu on this SMP machine (process affinity) ?
> 
> I there something like pset ?

http://isunix.it.ilstu.edu/~thockin/pset  - pset for linux-2.2 (not ported
to 2.4 yet)
