Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292634AbSBVQif>; Fri, 22 Feb 2002 11:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292655AbSBVQi0>; Fri, 22 Feb 2002 11:38:26 -0500
Received: from trained-monkey.org ([209.217.122.11]:3080 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S292634AbSBVQiR>; Fri, 22 Feb 2002 11:38:17 -0500
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15478.29686.862941.196746@trained-monkey.org>
Date: Fri, 22 Feb 2002 11:38:14 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ben Greear <greearb@candelatech.com>, Petro <petro@auctionwatch.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Eepro100 driver.
In-Reply-To: <3C767359.44CD415E@mandrakesoft.com>
In-Reply-To: <20020213211639.GB2742@auctionwatch.com>
	<3C6B2277.CA9A0BF8@mandrakesoft.com>
	<3C6B406E.1010706@candelatech.com>
	<3C6B4B20.FE4AE960@mandrakesoft.com>
	<d3sn7ttrcb.fsf@lxplus050.cern.ch>
	<3C767359.44CD415E@mandrakesoft.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> Jes Sorensen wrote:
>> Would be a lot nicer to see someone spending the time pulling the
>> useful bits out of e100 and putting it into eepro100. e100 is ugly
>> and bloated for no reason.

Jeff> When it passes my review, it will not be.

Jeff> e100 + my desired changes == eepro100 + my desired changes

Guess I just prefer to build bottom up with a basic clean code base
rather than a gross messy and bloated base.

Jes
