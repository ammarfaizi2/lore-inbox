Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280462AbRKEKbj>; Mon, 5 Nov 2001 05:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280472AbRKEKb3>; Mon, 5 Nov 2001 05:31:29 -0500
Received: from [195.63.194.11] ([195.63.194.11]:4104 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S280467AbRKEKbQ>;
	Mon, 5 Nov 2001 05:31:16 -0500
Message-ID: <3BE676AB.D777C9A0@evision-ventures.com>
Date: Mon, 05 Nov 2001 12:23:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <200111042213.fA4MDoI229389@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:

Every BASTARD out there telling the world, that parsing ASCII formatted
files
is easy should be punished to providing a BNF definition of it's syntax.
Otherwise I won't trust him. Having a struct {} with a version field,
indicating
possible semantical changes wil always be easier faster more immune
to errors to use in user level programs.
