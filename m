Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRLSSMO>; Wed, 19 Dec 2001 13:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281024AbRLSSMF>; Wed, 19 Dec 2001 13:12:05 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:63750 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280971AbRLSSL7>; Wed, 19 Dec 2001 13:11:59 -0500
Date: Wed, 19 Dec 2001 12:11:38 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Dead2 <dead2@circlestorm.org>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011219121137.C18888@asooo.flowerfire.com>
In-Reply-To: <E16GLmv-0007d4-00@the-village.bc.nu> <026701c187d5$ec2472c0$67c0ecd5@dead2> <20011218123724.A32316@asooo.flowerfire.com> <01121909274103.01840@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01121909274103.01840@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Dec 19, 2001 at 09:27:41AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:27:41AM -0200, vda wrote:
| On Tuesday 18 December 2001 16:37, Ken Brownfield wrote:
| > The CVS tree availability you mention parallels the FreeBSD tree, I
| > believe.  However, assuming enough brain cycles, one knowledgable
| > maintainer seems to be a better method of maintaining a kernel.
| 
| As tree gets larger over time, Linus *and* Alan hacking on the single tree in 
| CVS ought to be more productive than regular time consuming syncs between 
| Linus and -ac trees (but requires higher level of mutual trust).

Yes, I agree, this is somewhat along the lines what I mentioned -- a
main maintainer (Linus in this case) has their own CVS tree that they
can have specific people work on.  This example would be for the entire
kernel, and as you say trust would be required.  The number of people in
this specific case would be countable on one hand (or perhaps two
fingers), whereas instances of tree sharing within sub-parts of the
kernel could be wider and looser.

My only negative reaction would be a single kernel tree shared among
many/all developers, like more than two.

-- 
Ken.
brownfld@irridia.com

