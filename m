Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRHBRMv>; Thu, 2 Aug 2001 13:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHBRMm>; Thu, 2 Aug 2001 13:12:42 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:27916 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S266864AbRHBRMZ>; Thu, 2 Aug 2001 13:12:25 -0400
Date: Thu, 2 Aug 2001 13:12:34 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: university studies?
In-Reply-To: <3B693B46.585CC416@bilten.metu.edu.tr>
Message-ID: <Pine.LNX.4.33.0108021259080.31892-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Muzaffer Ozakca wrote:

>
> I don't think, one should learn all the "hot" languages of the day to
> become a good programmer. A computer science student should (and will)
> learn the theoretical background that lays beneath. Data structures,
> graph theory, computational linguistics, compiler theory, OS, AI, so on.
> Practical studies such as programming projects will let the students
> solid the theory. These thoughts are not actually mine, most of the
> computer science departments -more or less- follow a cirriculum
> appreciating these ideas, I think. However, a kernel (or systems)
> programmer should also know basics of microprocessors, interrupts, etc.
> and programming in assembly, besides the theory given in a university.
>
> After getting the theory and completing the understanding by practice,
> learning a programming language is just a detail. Always solving
> problems "C" style, may not be the best approach, a functional language
> may better suit the needs -usually not in our course.
>
> As far I could see, kernel programming (talking about the whole)
> requires the use of computer science, heavily.

I absolutely agree that learning programming languages isn't enough. However,
just learning algorithms and structures and doing programming projects isn't
enough either.

AFAIK, around where I am institutes of higher learning don't usually have a
great track record for exposing students to a wide variety of languages.
Usually it's Pascal and/or C/C++, with some Java mixed in. While they are
"nice" languages, there's a lot more to other languages than can be learned
from those four.

And having the theoretical background doesn't actually help you program. To
illustrate, here's a snippet of code similar to something I saw on a monitor
where I went:

typedef class {
  ...
} C;

main()
{
  C c;

  c.C();
    ...
};

While the student knew that objects have a constructor, he never realized
(was never taught?) that constructors are called implicitly.

Also, I did mention FP; I mentioned Lisp and XSLT as examples of FP languages.
And Python can be used in both structed and FP ways.

And yes, a course or two in digital electronics and microprocessors never
hurts either.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

