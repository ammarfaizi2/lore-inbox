Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272354AbRH3RVO>; Thu, 30 Aug 2001 13:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272352AbRH3RVE>; Thu, 30 Aug 2001 13:21:04 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:52452 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S272354AbRH3RU4>; Thu, 30 Aug 2001 13:20:56 -0400
Importance: Normal
Subject: Re: lcs ethernet driver source
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@fenrus.demon.nl (Arjan van de Ven), linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFA16538B8.61628554-ONC1256AB8.005D7C15@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 30 Aug 2001 19:20:04 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 30/08/2001 19:20:13
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:

>> Sorry, at this point we are not allowed to publish the source code of
the
>> lcs and qeth drivers (due to the use of confidential hardware interface
>> specifications).  We make those modules available only in binary form
>> on our developerWorks web site.
>
>Is there any plan to change this ?

This is not something we (the Linux for S/390 development team) can decide;
it's up to the hardware groups that 'own' the LCS / QDIO specifications
whether they allow to make these public.  As I said, at this point, we
are not allowed to open the specs; while it is conceivable that this might
change in the future, I'm not aware of any specific plan.

(Please note that I'm in no way speaking for IBM here; that's just my
personal opinion.)


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

