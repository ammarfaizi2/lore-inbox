Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289733AbSBESXF>; Tue, 5 Feb 2002 13:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSBESXB>; Tue, 5 Feb 2002 13:23:01 -0500
Received: from pca-232-254.stwr.brightok.net ([205.162.232.254]:27108 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S289733AbSBESWr>; Tue, 5 Feb 2002 13:22:47 -0500
Date: Tue, 5 Feb 2002 12:19:33 -0600 (CST)
From: "Daniel A. Newby" <newby@teco-xaco.com>
X-X-Sender: <newby@localhost.localdomain>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: opening a bzImage?
In-Reply-To: <Pine.LNX.4.30.0202051538440.13346-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0202051157130.3136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote (Tue, 5 Feb 2002):
> 
> Btw.. Does GPL require them to give me the .config file?

Yes.  To paraphrase, "You may copy and distribute the Program in
executable form provided that you also accompany it with the
complete corresponding machine-readable source code (or a promise
to distribute source upon request, or a copy of the promise given
to you)."

Complete source code for an executable work is defined as "all the
source code for all modules it contains, plus any associated interface
definition files, plus the scripts used to control compilation and
installation of the executable."

IMHO, .config is a "script used to control compilation".

(This is a point in favor of saving .config in the kernel by default.  
A competent build system that saves it separately may be desirable, but
that is of no help when faced with incompetence and/or malice.)

