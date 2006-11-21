Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031398AbWKUUZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031398AbWKUUZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031401AbWKUUZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:25:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:40120 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1031398AbWKUUZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:25:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SED+Tso74+yjMD0zFSpxptB0co5h0gltpaYkxmr7sJSitSboV5/7GFP7GRlP8Uo7io8IBUmthNnRfgsnjjvF1ItCgu3oY5VzGgIMYxYjptx3aMzGXqnNVKMKRW/0HPtxaqOcu14MLiXDMUh6NZWhL3OxwjZ14CO9xpwh5IR+WAg=
Date: Tue, 21 Nov 2006 21:25:41 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Chris Snook <csnook@redhat.com>
Cc: Jay Cliburn <jacliburn@bellsouth.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
Message-ID: <20061121202541.GA23036@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119202817.GA29736@osprey.hogchain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Snook <csnook@redhat.com> ha scritto:
> Jay Cliburn wrote:
>> Based upon feedback from Stephen Hemminger and Francois Romieu, please
>> consider this resubmitted patchset that provides support for the Attansic 
>> L1 gigabit ethernet adapter.  This patchset is built against 2.6.19-rc6.  
>> The original patchset was submitted 20060927.
[...]
> 
> I've been working on this with Jay since his initial submission.  Thanks 
> to everyone who has provided feedback on the resubmit.  We're currently 
> quite short on actual testers, since the chip only seems to be on Asus 
> M2V motherboards at present.  Please let me and Jay know if you have one 
> of these boards and would like to test and/or have encountered bugs.

Asus P5B-E also has L1 chip. I'll get the board in a few days and I'll
test whatever patch you throw at me ;)

Luca
-- 
Not an editor command: Wq
