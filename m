Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDPRBJ>; Mon, 16 Apr 2001 13:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRDPRA7>; Mon, 16 Apr 2001 13:00:59 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:56076 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131614AbRDPRAs>;
	Mon, 16 Apr 2001 13:00:48 -0400
Date: Mon, 16 Apr 2001 13:02:00 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML2 1.1.0 bug and snailspeed
Message-ID: <20010416130200.A18768@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010415114319.00b13350@pop.cus.cam.ac.uk> <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk> <002601c0c4fb$c7e54260$0201a8c0@home> <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk> <20010414135618.C10538@thyrsus.com> <5.0.2.1.2.20010415114319.00b13350@pop.cus.cam.ac.uk> <20010415135906.A5501@thyrsus.com> <5.0.2.1.2.20010416005432.00ac81a0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010416005432.00ac81a0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, Apr 16, 2001 at 12:55:49AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk>:
> I can't reproduce it with ttyconfig either. But here is how to reproduce it 
> reliably with menuconfig:

Excellent!  I was able to reproduce it and track it down.  This will be fixed
in tonight's release.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

He that would make his own liberty secure must guard even his enemy from
oppression: for if he violates this duty, he establishes a precedent that
will reach unto himself.
	-- Thomas Paine
