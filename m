Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbREMQpO>; Sun, 13 May 2001 12:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbREMQpF>; Sun, 13 May 2001 12:45:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58894 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261418AbREMQoy>;
	Sun, 13 May 2001 12:44:54 -0400
Date: Sun, 13 May 2001 17:44:29 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010513174429.A5904@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:
> Reasoned objections can change my behavior. Grunting territorial
> challenges at me will not. You have two options: (1) persuade Linus
> that the whole CML2 thing is a bad idea and should be dropped, or (2)
> work with me to correct any errors I have made and improve the system.
> Growling at me and hoping I go away won't work, not when I've invested
> a year's effort in this project.

Eric, you're trying to do too much too quickly.  Wait until 2.5 to clean
stuff up.  That's what the rest of us have to do, even for some things
which are real bugs rather than infelicities in the current design.
You can't treat this as an all-or-nothing deal.  Some of your ideas for
CML2 are right, and some aren't.  Get the non-controversial bits in,
then fight over the ideas that're worth fighting for.

Yes, CML2 enables a more task-based than hardware-based approach, and
I think that's generally a good thing; but I do believe that this isn't
going to be suitable for everyone.  Let's work up to it gradually.

-- 
  One of the most insidious things the CIA Communists did when they took
over Unistat was to change the Constitution.
  The original Constitution, having been written by a group of
intellectual libertines and Freemasons in the eighteenth century,
included an amendment which declared:
      A self-regulated sex life being necessary to the happiness of a
      citizen, the right of people to keep and enjoy pornography shall not
      be abridged.
  This amendment had been suggested by Thomas Jefferson, who had over nine
hundred Black concubines, and Benjamin Franklin, a member of the Hell
Fire Club, which had the largest collection of erotic books and art in
the Western world at that time.
  The Communists changed the amendment to read:
      A well-regulated militia being necessary to the security of a free
      state, the right of the citizens to keep and bear arms shall not
      be abridged.
  All documents and textbooks were changed, so that nobody would be able
to find out what the amendment had originally said.  Then the Communists
set up a front organisation, the National Rifle Association, to encourage
the wide usage of guns of all sorts and to battle any attempt to control
guns as "unconstitutional."
  Thus, they guaranteed that the murder rate in Unistat would always be
the highest in the world.  This kept the citizens in perpetual anxiety
about their safety both on the streets and in their homes.  The citizens
then tolerated the rapid growth of the Police State, which controlled
almost everything, except the sale of guns, the chief cause of crime.

-- Robert Anson Wilson in the Schroedinger's Cat Trilogy
