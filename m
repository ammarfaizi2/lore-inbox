Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262308AbRE2E0d>; Tue, 29 May 2001 00:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262347AbRE2E0X>; Tue, 29 May 2001 00:26:23 -0400
Received: from mail08.voicenet.com ([207.103.0.34]:11648 "HELO
	mail08.voicenet.com") by vger.kernel.org with SMTP
	id <S262308AbRE2E0R>; Tue, 29 May 2001 00:26:17 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: safemode <safemode@voicenet.com>
To: Jakob =?iso-8859-1?q?=D8stergaard?= <jakob@unthought.net>,
        "G. Hugh Song" <ghsong@kjist.ac.kr>
Subject: Re: Plain 2.4.5 VM...
Date: Tue, 29 May 2001 00:26:08 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105290232.f4T2W9m00876@bellini.kjist.ac.kr> <20010529061039.D29962@unthought.net>
In-Reply-To: <20010529061039.D29962@unthought.net>
MIME-Version: 1.0
Message-Id: <01052900260800.29037@psuedomode>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 May 2001 00:10, Jakob Østergaard wrote:

> > > Mem: 381608K av, 248504K used, 133104K free, 0K shrd, 192K
> > > buff
> > > Swap: 255608K av, 255608K used, 0K free 215744K
> > > cached
> > >
> > > Vanilla 2.4.5 VM.

> It's not a bug.  It's a feature.  It only breaks systems that are run with
> "too little" swap, and the only difference from 2.2 till now is, that the
> definition of "too little" changed.


Sorry but if ~250MB is too little ... it _is_ a bug.   I think everyone would 
agree that 250MB of swap in use is far far far too much.  If this is a 
feature, it is one nobody would want.  
