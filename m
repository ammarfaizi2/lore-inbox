Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311475AbSDQR6r>; Wed, 17 Apr 2002 13:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311483AbSDQR6q>; Wed, 17 Apr 2002 13:58:46 -0400
Received: from smtp.acn.pl ([212.76.33.20]:46187 "EHLO mail.astercity.net")
	by vger.kernel.org with ESMTP id <S311475AbSDQR6q>;
	Wed, 17 Apr 2002 13:58:46 -0400
Date: Wed, 17 Apr 2002 19:57:16 +0200
From: Artur Brodowski <bzd@astercity.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops report (or at least a try to make one)
Message-Id: <20020417195716.5f807f35.bzd@astercity.net>
In-Reply-To: <Pine.LNX.4.44.0204171331210.30470-100000@netfinity.realnet.co.sz>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002 13:31:51 +0200 (SAST)
Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
> > > Regarding the Tainted flag, are you loading nvidia's latest and greatest 
> > > by any chance ?
> > yes, i do - 1.0.2880 that is.
> I've seen a similar looking stack trace with the new drivers at home and a 
> couple of times on the list.
well, looks like it's really latest nvidia driver issue. i found out that
few people from polish linux newsgroup also encountered this problem 
(different systems, same nv 1.0.2880). i booted up with native X driver,
as Alan Cox recommended and everything worked fine for couple of hours. 
then i downgraded them drivers to 2313 and again - no probs, at least 
until now ;).
thank you for your help,
artb.

