Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWCHJfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWCHJfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWCHJfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:35:13 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:41407 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932529AbWCHJfM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:35:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gcVpNgBXifpnykzPRUEkIQ8qONyzEt4YLYqpxsXRNzWFWQkAmvSdueFU2JwQ5aem6iR3X3pJhIBepUTuQfvvdEnoEf7/ASIEwvhgQMC8g3SR2mECG9fV7fvMA1pxM5gHdt3KrAot9wtYXURXHJKjlrlrUvZ6MIiL2hgYYZDxMGo=
Message-ID: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
Date: Wed, 8 Mar 2006 15:05:11 +0530
From: "Anshuman Gholap" <anshu.pg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [future of drivers?] a proposal for binary drivers.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First, I would like to give you my intro, so that you have a picture
who is talking. I am 28 year old from india working as administrator
for a hosting company (not naming here cause that will be cheap way to
advert it).  We have 100+ servers (shared,semi-dedicated and
dedicated) and growing steadily, all have linux-distros ofcourse (many
RHEL).

But i also have 3-4 pc's with me and one laptop, most of them have 
linux installed, i go digicam not working on linux, webcam not working
on linux, dlink 630d pcmcia card not working natively on linux, the
list is just too big here (sony 510i not working, etc).

I had read earlier Linus Travolds totally opposes the idea of allowing
binary drivers to exists along with kernel, but on other hand, i also
heard lots like, how andrew morton is stretched for supporting the
programmers at various companies who keep sending him drivers for
their devices .

1) The people who have control over linux kernel as of now are
countable on hands but cannot be held countable for work cause they do
it as hobby/"insert anything which says working for free", now for a
peice of code like linux kernel, such kind of aloofness regarding
manpower and kind_of nazism in not allowing others to dynamically
get_work_done (like binary driver) seems totally wrong.

2) there are two possibilities here, a) linus and co can gather in a
building pay all intellects and allow fast driver developments, b)
allow binary drivers to work with linux kernel dynamically(with their
own license what they choose).

b) ofcourse is like china accepting democracy cause that the only way
to continue living, but although it sounds that extreme, i can see
ONLY THAT to happen sooner or later when one day linus is not part of
the team controlling linux kernel, so why not start to make it happen
right now and shape it the way it can be benificial to everyone?
like there is mm kernel we can have kernel-dri-2.*** which the desktop
users can use knowingly that third party drivers can work with mixture
of lincenses. there even can be rating system for a company which can
be rated for their quality of drivers, so the users know before hand.
how good or bad the driver (even if he/she isnt codeguru).

This email is very raw and not polished at all, this is just a bunch
of thoughts which has came to my head after working with linux based
distros on home computers as well as enterprise servers years and
years now.

If something i said here is wrong , i apologise and correct me where
you feel so.

Regards,
Anshuman Gholap
admin.
