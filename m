Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbTBDAYf>; Mon, 3 Feb 2003 19:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBDAYf>; Mon, 3 Feb 2003 19:24:35 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:30438 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267042AbTBDAYe>; Mon, 3 Feb 2003 19:24:34 -0500
Date: Tue, 04 Feb 2003 13:34:33 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Compactflash cards dying?
Message-ID: <286350000.1044318873@localhost.localdomain>
In-Reply-To: <200302040056.02287.roger.larsson@skelleftea.mail.telia.com>
References: <20030202223009.GA344@elf.ucw.cz>
 <200302040056.02287.roger.larsson@skelleftea.mail.telia.com>
X-Mailer: Mulberry/3.0.0b12 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========710758336=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========710758336==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



--On Tuesday, February 04, 2003 00:56:00 +0100 Roger Larsson=20
<roger.larsson@skelleftea.mail.telia.com> wrote:

> On Sunday 02 February 2003 23:30, Pavel Machek wrote:
>> Hi!
>>
>> I had compactflash from Apacer (256MB), and it started corrupting data
>> in few months, eventually becoming useless and being given back for
>> repair. They gave me another one and it is just starting to corrupt
>> data.
>>
>> First time I repartitioned it; now I only did mke2fs, and data
>> corruption can be seen by something as simple as
>>
>> cat /mnt/cf/mp3/* > /mnt/cf/delme; md5sum /mnt/cf/delme.
>>
>> [Fails 1 in 5 tries].
>
> That is very bad... I wonder if you do something that the CF does
> not like - like power off while writing (can actually destroy the
> disk - read in some newsgroup)

Maybe your system is feeding it the wrong supply voltage?

>
>>
>> Anyone seen something similar? Are there some known-good
>> compactflash-es?
>>
>
> I would recomend SanDisk

Seconded, they're generally really good.

Andrew
--==========710758336==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+PwqaHamGxvX4LwIRAh88AJ42l8rEsVmdLNGdP0wrqj+q1gKP9ACg0AQk
dn0dIfLSHg1M9ARx5lVLmfE=
=oJec
-----END PGP SIGNATURE-----

--==========710758336==========--

