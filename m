Return-Path: <linux-kernel-owner+w=401wt.eu-S1752609AbWLXTeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbWLXTeL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWLXTeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 14:34:11 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:48041 "HELO
	smtp102.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752609AbWLXTeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 14:34:10 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 14:34:10 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:X-YMail-OSG:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=0sjV+kGGSa6g02XymHy+yO4pbwyfN9kiHMBbnU6pKcDkY2eGoejm0FJa0kan95woXB5MiGO6ZVoScEwx7OnfYG2jONPZ7/SvANl5uR/BOiZmiyjz3iW26ov96jtQu8xmltIM/ScCYFr4scr5WWI9szM17qZeCKBxMe57pRxP7ZA=  ;
X-YMail-OSG: VETYLMoVM1mAIXMnsnl4Wu2zjvLA5PV8DXAkT8JO_Pt_8_4Z6UfQlFEjMEtvRDzIvqYOdGrDQnv_HXe5684BNFaPflg6GONNzD6lwY8bdY4IIa952oJ9I2x16BCjLS4uWQ3CLu39uka2QqDvvhpV3507IGlwHbiByu91hHdBZJcjkv.Ddy0eLRmuwywP
Subject: RE: Binary Drivers
From: James C Georgas <jgeorgas@rogers.com>
To: davids@webmaster.com
Cc: Valdis.Kletnieks@vt.edu,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEAGAJAC.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKIEAGAJAC.davids@webmaster.com>
Content-Type: text/plain
Date: Sun, 24 Dec 2006 14:27:28 -0500
Message-Id: <1166988448.12881.92.camel@Rainsong>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-24-12 at 09:33 -0800, David Schwartz wrote:
> > On Fri, 22 Dec 2006 23:19:09 PST, David Schwartz said:
> 
> > > You can't sell something that doesn't exist. If you sell a car
> > > even though
> > > you can't explain how anyone could drive it, that's fraud.
> 
> > Are they allowed to sell a car that incorporates a computer that uses a
> > trade-secret algorithm for controlling the fuel injection to get 20 more
> > horsepower and 5% better mileage?
> 
> I assume that's a rhetorical question. Of course they are.
> 
> Now, let's try it another way: Are they allowed to sell a car that
> incorporates a computer that uses a trade-secret algorithm for controlling
> the fuel injection to get 20 more horsepower and 5% better mileage if it's
> impossible to *start* the car without knowing that algorithm?
> 
> Then, I think it's obvious the answer is, of course, no. If you buy the car,
> they have to tell you the algorithm.
> 
> If knowledge of the algorithm is required to use the car in a reasonable
> way, even if it's not the normal expected way, then they can't keep it
> secret. They can't sell something while keeping secret how to *use* it. And
> that doesn't just mean the normal expected use. Buying something free and
> clear allows you to use it even in unusual ways.
> 
> Perhaps that wasn't the best example. Let's try another one. You buy a car,
> and then discover that the car computer has a lockout and a code needs to be
> entered on the alarm panel to start the car between 4 AM and 4:15 AM on
> Tuesdays. You ask the manufacturer for that code, since you would like to
> start your car between 4 AM and 4:15 AM on Tuesdays even though many people
> don't.
> 
> How many of the following answers would you consider fair:
> 
> 1) We never wrote the code down. We knew it, but we didn't put it in a form
> in which we can give it to you. Most people don't need it anyway. Sorry.
> 
> 2) We're sorry. We know the code, but our contract with another company
> prohibits us from disclosing it.
> 
> And so on.
> 
> Buying the car includes the right to start it between 4 AM and 4:15 AM on
> Tuesdays if that's what you want to do. If the manufacturer couldn't sell
> you the right or ability to do that, it couldn't sell you the car.
> 
> Owning a video card includes the right to make it work with Linux if that's
> what you want to do. If the manufacturer couldn't sell you the right or
> ability to do that, it couldn't sell you the video card.
> 

Here's my personal favourite example:

	You walk into a car dealership to buy a new car, because your old car
is too slow to drive on the freeway; you need something faster.

	The salesman shows you a great vehicle. He tells you all about how this
car is the pinnacle of automotive technology. It's got muscle. It's got
finesse. It's got tons of state of the art bells and whistles. Your
friends will be soooo jealous. Chicks will dig you. You have to have it.
You pay the man and have it delivered to you house.

	When it arrives, you can't figure out how to open the door. The front
windows are opaque, so you can't see inside.

You: "Hey, delivery guy. How do I open the door on this thing?".

Guy: "I'm not the delivery guy. I'm your driver."

You: "Huh? Look, I don't need a driver, OK? I'll drive it myself. So how
do I open the door?"

Driver: "I'm sorry sir, but I can't tell you that. It's secret car
company stuff. If I told you, then our competition might find out how we
do it, and we would lose our competitive advantage."

You: "Whatever. I need to get to work. Let's go."

	You get in the back seat, but there is an opaque barrier between you
and the front of the car.

Driver: "Just talk into the speaker on your left, sir, and I'll go where
you tell me to."

	You get out on the freeway, but you're only going 30 kph.

You: "What the hell is wrong with this thing? I thought this car was the
fastest thing on the road. Pick it up, why don't you?"

Driver: "I'm sorry sir. I don't really know how to make the car go
faster than 30 kph. This is a new model, and the company hasn't yet
taught us how to drive it fast. Check in with them next month. They're
always training new drivers, and they might have a replacement for you
by then."

You: "Well that's just great. Let's get off the freeway. Take a left on
Broadway, at the bottom of the off-ramp."

	You exit the freeway, but as you are turning left onto Broadway, your
car stalls in the intersection.

You: "Hey driver, WTF?"

Driver: "Sorry Sir, I seem t0 baeo ++_?+CFY^K$# ekbae."

	The driver stumbles out of the car and starts spazzing out on the
ground. After a couple of minutes he's OK and you get back on the road.
There's an uncomfortable silence in the car. You don't tell him to turn
left any more.

	Six months later, the company sends you a replacement driver.

Driver2: "Sorry it took so long sir. You see, there's not much call for
drivers who know the streets in this neighbourhood, or that speak your
language. Most of our clients speak Esperanto, and are over in the
business district. They have priority when drivers are trained."

	The new driver can reach 70kph and he turns left by turning right three
times, so things are looking up. Still, the salesman told you this baby
can go 300kph, and you want to see it happen. You go to the company HQ
to talk with someone.

	When you get there, the office is cleaned out, and there are eviction
notices plastered on the doors. Oh well, at least you still have a
driver. As long as the city doesn't alter the street layout in your
neighbourhood, he'll do just fine.

