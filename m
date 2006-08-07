Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWHGA5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWHGA5A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 20:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWHGA5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 20:57:00 -0400
Received: from smtp108.rog.mail.re2.yahoo.com ([68.142.225.206]:19535 "HELO
	smtp108.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750868AbWHGA5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 20:57:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:References:In-Reply-To:Cc:MIME-Version:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=L1d27I6SOlUzGE7AEHDLeiKtVu0X1v/QCdc3R2/zZpUfWbEGjaD3rVGbK2YyorBxaS9FzrFnOfyalzjBTfnLPp7DoDQhFNxqRfPEg2toCXcxre2BeStP8xd2IevLI8ZiUDGIVJTtT+l+Tx6q7zYGgP9c6RJ9k8JG1yKrnLtuxE4=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: hdaps-devel@lists.sourceforge.net
Subject: Re: [Hdaps-devel] [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Date: Sun, 6 Aug 2006 20:56:53 -0400
User-Agent: KMail/1.9.3
References: <11548492171301-git-send-email-multinymous@gmail.com> <20060806145551.GC30009@thunk.org> <41840b750608061508j9e731c4hf9de7b389c46c916@mail.gmail.com>
In-Reply-To: <41840b750608061508j9e731c4hf9de7b389c46c916@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, "Shem Multinymous" <multinymous@gmail.com>
MIME-Version: 1.0
Message-Id: <200608062056.54150.shawn.starr@rogers.com>
Content-Type: multipart/signed;
  boundary="nextPart4447631.sK3dDyHlfO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4447631.sK3dDyHlfO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 06 August 2006 6:08 pm, Shem Multinymous wrote:
> Hi Ted,
>
> Thanks for the explanation. Point taken, though I can't help parsing it a=
s:
>
> On 8/6/06, Theodore Tso <tytso@mit.edu> wrote:
> > For legal reasons, we need a way to to contact and identify the author
> > in the real world, not just in cyberspace, and a pseudonym doesn't
> > meet that requirement.
>
> "We want to be able to sue you if they sue us."
>
> Which is actually not a problem for me (i.e., I don't believe I have
> nothing to worry about legally); but I do have other, non-legal
> considerations.
>
> > just as the fact that we aren't requiring ink signatures and public
> > notary checks doesn't mean we shouldn't stop doing what we are doing.
>
> Understood, but still a bit silly. You have no idea how many of the
> 2252 people in `git-whatchanged | grep Signed-off-by: | sort | uniq`
> gave their legal name, and I doubt you could contact most of them in
> the real world without their cooperation (and with my cooperation, you
> could contact me too). Heck, some of those email domains don't even
> resolve. So this "chain of responsibiliy" is pretty worthless if
> someone really tries to inject legally malicious code into mainline,
> i.e., you end up blindly trusting people anyway.
>
> BTW, Ted, we actually have met in person. :-)
>
>   Shem

This is where GNU PGP keys can help. If more people used them, as a trust=20
mechanism it would help people trust people more. Otherwise, what's the poi=
nt=20
of these keysignings? :-)

I don't mind providing my PGP key if it helps people recognize I am who I a=
m=20
via email and signed patches.

Shawn.


--nextPart4447631.sK3dDyHlfO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE1o/WsX/SQXZigqcRAlBxAJ9r9K1+Z+6cdW84MKIQU0OcPrNxgACcCqxR
ax9YSF3qtX0fa+RXcAf34r8=
=Vrtc
-----END PGP SIGNATURE-----

--nextPart4447631.sK3dDyHlfO--
