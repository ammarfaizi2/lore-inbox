Return-Path: <linux-kernel-owner+w=401wt.eu-S1423116AbWLUWDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423116AbWLUWDF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423119AbWLUWDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 17:03:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:40307 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423116AbWLUWDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 17:03:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AfbVPIKHSz29ePJ1d9f7M7V68OUWDRxhyBLJYb93jxFM2KCU0h+q6JBuwXz5tS48xg18IIDW/mp7htnR+OaF9fpY3etIJikYkj7eK/sXb9SY7g7DycQ1OYCWUyR8H0FnYb7ILS0Od+BQ4Ezhl7uWc8eGnLondpHqswI9T3InLwc=
Message-ID: <7b69d1470612211402l497d559o976e00e1d3cc823@mail.gmail.com>
Date: Thu, 21 Dec 2006 16:02:58 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Binary Drivers
Cc: "Tomas Carnecky" <tom@dbservice.com>,
       "Alexey Dobriyan" <adobriyan@gmail.com>,
       "James Porter" <jameslporter@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m1hcvpngtj.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <loom.20061215T220806-362@post.gmane.org>
	 <20061215220117.GA24819@martell.zuzino.mipt.ru>
	 <4583527D.4000903@dbservice.com>
	 <m13b7ds25w.fsf@ebiederm.dsl.xmission.com>
	 <7b69d1470612210833k79c93617nba96dbc717113723@mail.gmail.com>
	 <m1hcvpngtj.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Scott Preece" <sepreece@gmail.com> writes:
>
> But as it happens that driver does not work for a large segment
> percentage of linux users who potentially could place the card in
> their system.  Did that driver support all 23 architectures?
---

Do they claim it does? There is NO moral obligation that they support
every piece of hardware in the world. They are offering a product
under certain terms. You can choose to buy it or not. If you have
standing, and believe that their driver infringes the Linux
copyrights, then you could also sue, but the most you could hope to
win is making the driver unavailable, which makes the hardware
unavailable. That still feels like a Pyrrhic victory to me.

---
> The difference is that we don't expect the hardware manufactures to do
> anything we only hope they will support linux.  Once they support
> linux we do expect they will play well with others and if they don't
> then it is rude.
---
Not everyone agrees that it is better to not have the device available
for Linux at all than to have it with a closed driver. Again, note
that the manufacturer services all other OS platforms with closed
drivers, so you're asking them to do something different, that
probably costs them something in startup cost, and potentially costs
them something in downstream support.

---
>
> Please none of this amoral Neither is wrong crap.
---

It's not a moral question. The hardware vendor says - "This is what we
make. You can buy it if you like and we will support it to the extent
defined in our support policy. If those terms don't work for you, or
it doesn't work with your hardware, then we're sorry; we can't help
you at this time."

scott
