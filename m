Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTBPRbW>; Sun, 16 Feb 2003 12:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbTBPRbW>; Sun, 16 Feb 2003 12:31:22 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:37905 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267284AbTBPRbV>; Sun, 16 Feb 2003 12:31:21 -0500
Date: Sun, 16 Feb 2003 17:41:18 +0000
From: John Levon <levon@movementarian.org>
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030216174118.GA63890@compsoc.man.ac.uk>
References: <Pine.LNX.4.50.0302161205240.578-100000@montezuma.mastecende.com> <Pine.SOL.3.96.1030216225625.25827E-100000@osiris.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1030216225625.25827E-100000@osiris.csa.iisc.ernet.in>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18kSn0-000Nq5-00*gT3l/p2NHwI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 10:57:50PM +0530, Rahul Vaidya wrote:

> I am getting the same error even for 2.5.61
> 
> Please cc any replies to rahulv@csa.iisc.ernet.in

Have you made a softlink for gcc ? Apparently that doesn't work well
with recent gcc versions finding the headers...

john
