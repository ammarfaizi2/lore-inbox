Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274034AbRISJig>; Wed, 19 Sep 2001 05:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274029AbRISJi0>; Wed, 19 Sep 2001 05:38:26 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:32781 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274028AbRISJiH>; Wed, 19 Sep 2001 05:38:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ebiederm@xmission.com (Eric W. Biederman),
        "Rob Fuller" <rfuller@nsisoftware.com>
Subject: Re: broken VM in 2.4.10-pre9
Date: Wed, 19 Sep 2001 11:45:44 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907BB98@xchgind02.nsisw.com> <m166ahst39.fsf@frodo.biederman.org>
In-Reply-To: <m166ahst39.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010919093828Z17304-2759+92@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 17, 2001 06:03 pm, Eric W. Biederman wrote:
> In linux we have avoided reverse maps (unlike the BSD's) which tends
> to make the common case fast at the expense of making it more
> difficult to handle times when the VM system is under extreme load and
> we are swapping etc.

What do you suppose is the cost of the reverse map?  I get the impression you 
think it's more expensive than it is.

--
Daniel
