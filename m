Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUH1RNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUH1RNc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUH1RNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:13:32 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:31701
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S267474AbUH1RNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:13:09 -0400
Message-ID: <4130BD39.2020608@winischhofer.net>
Date: Sat, 28 Aug 2004 19:13:29 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
References: <412F4008.4050700@winischhofer.net>	 <20040827130151.46c246b0.davem@redhat.com>	 <412FF60B.5080009@winischhofer.net> <1093676112.2792.6.camel@laptop.fenrus.com> <41309AA8.7070206@winischhofer.net>
In-Reply-To: <41309AA8.7070206@winischhofer.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Reply to Arjan's mail further below)

To avoid misunderstandings:

Thomas Winischhofer wrote:
> See, I know very well what "moral rights" are. But I am having a hard
>  time seeing your point here.

"Moral rights" = copyright law term here.

[...]

> The GPL is the legal AND "moral" "glue" of the Linux kernel. It is 
> the basis of our cooperation, and it defines our relation to the 
> user.

"Moral" meaning "morality" here, not to be mixed up with the copyright
law term of "moral rights".

[...]

> I am pretty sure, even the Netherlands rate "pacta sunt servanda" (as
>  a "moral" law since at least stone age as well as a written law
> since the Roman empire) above obeying a child's immediate
> overreaction to a more or less painless slap on his rear. Even on a
> morality scale since "law" in any regard in the end is the result
> from a common "moral" of a society.

Again, read "morality" or "morals".

Arjan van de Ven wrote:
> Ok then you know that
> 
> 1) there are moral rights you can't sign away no matter what
> contracts etc there are 

Yes.


 > 2) the amount of moral rights changes per country

Yes.


 > 3) berne convention roughly says "respect the copyright law
> from country f author" which is why dutch moral rights are relevant
> since the author lives in .nl


Yes. This is actually an important point for this discussion: Other 
countries' copyright laws DO NOT MATTER here. (Hence no need to broaden 
this discussion beyond dutch copyright law.)


>> A license is a contract. A contract is a *mutual* agreement on 
>> rights and obligations.
> 
> 
> I'm not sure the "license is a contract" thing is entirely valid in
 > europe.
> License and contract are separte items; a contract can give you a 
> license, but it's not clear that a license also is a contract. 
> (because in europe, a contract without BOTH parties agreeing to
 > eachother is not a real contract, and EULA's and such kinda are deep
 > into the gray area of that). But it's besides the point mostly.


Granted. The details of contract law, with respect to declaration of 
intention and declaration of acceptance, are somewhat a grey zone.

But if am not very mistaken, *all* juridical systems in Europe see a 
license as a contract. For the legally uneducated, this seems somewhat 
odd for the case of the GPL (since there is no real return) but "looks" 
entirely ok for license agreements where the license is granted in 
return for money.

But even donations are contracts and not unilateral transactions. The 
donor cannot claim the donation back (without very limited reasons that 
are not relevant here). Nothing else applies to a license without return.

The GPL itself, in clause 5, requires "acceptance". That is also a clear 
indication of its contractual nature.

And now for the moral rights (now: copyright law term):


> Ok so in .nl the moral rights an author has are
> 
> 1) The right to be visible as author in/with/at publications of the 
>    work 

Not an issue here. (If it were, it would have been previously as well.)


 > 2a) The right to object to publication when it is done such that it
 >     appears that someone else is the author


Not an issue here. (If it were, it would have been previously as well.)


 > 2b) The right to object to publication of the work under a different
 >     name of the work


Not an issue here. The name is "pwc" or "pwcx". I am not aware of any 
intentions of changing this.


 > 3) The right to object to any other modification in/to the work,
 >    unless the modification is of such nature that it is unreasonable
 >    to object to


See below


> 4) The right to object to mutilation/damage of the work when it hurts
 >    the good name or dignity of the author


Not an issue here.


These rights are the usual moral rights (now: copyright term) of most 
copyright laws I have come across yet.


> 3) is the key one here but even 2) is somewhat. If the author wants 
> to be rude and makes claim based on these, 

... and this claim is validated by a court ...

 > nobody can distribute the
> work under the GPL anymore since those requirements would then be a 
> direct conflict with that license.

Granted. However, I don't see either 2) or 3) as a problem here.

2): As said, as long as the name isn't changed, there is no basis for a 
claim. And for 2a): If this has not been valid for the last 4 years, why 
should it be in case we keep the driver in the kernel now? The GPL 
states that copyright notices (and this is nothing else than a pointer 
to the author) are to be left intact. If the GPL is obeyed (and that is 
assumed, of course), this moral right isn't touched either.

For 3): The limit for any claim at court is chicanery, even if the claim 
by the letter of the law is valid. This is also expressed by 
"[un]reasonable" in the wording, and is a general principle of western 
juridical systems. "Chicanery" is commonly defined by "raising a claim 
where the intention to persecute or damage the defendant outweighs any 
other interests of the plaintiff."

The intention of this clause (3) is to avoid changes that compromise the 
copyright holder's creativity. But keep in mind that the "idea" or any 
algorithm is not covered by copyright law.

We are only speaking about the open source part of the driver, not the 
binary part. The binary part is outside the scope of the license of the 
open source part.

The open source part and the binary part is not "one" work. It is two. 
The one and only "work" is the open source part.

Of all changes I can think of (apart from removing the hook, see below), 
I find none whose nature would make it reasonable to object it beyond 
pure chicanery.

As for the hook, one could argue that removing the hook is such a 
change: It could compromise the work (respectively the author's 
creativity) by damaging its interoperability capabilities. I tend to 
assume that is a valid point, based entirely on the moral rights.



I will continue here later today. Time's up for now.


> Now, it's not black/white. There is a clause in the same law that 
> says that an author can chose to abandon rights 2a), 2b) and 3)
 > "insofar as modifications to
> the work are concerned" and one can argue that releasing under the 
> GPL by the original author is such abandoning. But that is not quite 
> clear.

So, in my opinion, the moral rights Nr 2) aren't even damaged by keeping 
the driver in the kernel. Basically, it is not even required to abandon 
these rights.

As regards 3), I will continue later as said.


Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
