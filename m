Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312373AbSCUPiq>; Thu, 21 Mar 2002 10:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSCUPig>; Thu, 21 Mar 2002 10:38:36 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:22986 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S312373AbSCUPi0>; Thu, 21 Mar 2002 10:38:26 -0500
Subject: Re: [PATCH] 2.5.7 Documentation/00-INDEX
From: Steven Cole <elenstev@mesatop.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203210856100.21698-100000@filesrv1.baby-dragons.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 21 Mar 2002 08:35:36 -0700
Message-Id: <1016724936.2266.6.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-21 at 06:58, Mr. James W. Laferriere wrote:
> 
> 	Hello Rolf & all ,
> 
> On Thu, 21 Mar 2002, Rolf Eike Beer wrote:
> > Am Thursday 21 March 2002 09:12 schrieben Sie:
> > > Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de> writes:
> 
> > -Configure.help
> > -	- text file that is used for help when you run "make config"
> 	Why are we loosing the help file ?
> 	What are we replacing it with ?  Tia ,  JimL

The Documentation/Configure.help file has been replaced with 107
Config.help files in 2.5.7 (109 files in 2.5.7-dj1).  Do this:

find . -name Config.help

Steven


