Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUJXAiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUJXAiL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 20:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUJXAiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 20:38:11 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:36483 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S261339AbUJXAiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 20:38:06 -0400
Message-ID: <417B1574.4090406@slaphack.com>
Date: Sat, 23 Oct 2004 21:37:40 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.9-mm1
References: <20041023165712.GR26192@nysv.org>
In-Reply-To: <20041023165712.GR26192@nysv.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Markus Törnqvist wrote:
| Hans Reiser wrote:
|
|
|>Please make large keys the default, and hide the ability to
|>choose small keys by taking it out of the configuration menu and burying
|>it in a .h file.
|
|
| Stupid question, why have small keys at all?
|
| Someone said once that he didn't want to use large keys because they added
| no value to him and small keys wasted less space. If there are people like
| this around, burying it is not cool, but if there aren't, maybe small keys
| should be ripped out?
|
Some people don't care about speed but need space.  I'd leave them in on
general principle, even if no one wants them now.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQXsVdHgHNmZLgCUhAQKHUw/+MV9AQoOvM/bHz8urjetTDI5aPTdgiVNv
xO9naLp7uhPw5GrYAOPeXNq+3QTmXqU0MMOgyOBtp/7AkIa36jwA6wLO3yf1CR+E
njhYphwV630QDTugJfIgG0EKdPabM6tVmbTzw4IVpe4ULgK1IeAqkN99AGMr07+x
nhZj0OgSrmOh8UMOTiBgQ0CT1imSgMgTPqDUQTmh6XZeOi7Vqvdb734/nzw3/X6D
ECGNTcmaRG0oQUnFAN0mLVwoa8lTvnCB4q5W73txj4geKFcozsMqd95UXNboCs/9
9Z5bsDUFYOM0HUSaXqtCgmLvGyLhGwkMokYCy6I2tWcjEeHkOaawOXmJCmR/QFm3
OW5Mo7dWIsusexOFGhqZrK8N1l9VDzZKEScDSw1wIIspENnGL4mijL4NOU90Y33t
00tr2K4/g5yk76qI7pfKW33cWs0ZOpqeLAnuVKCglQMTd5x8YQ3B2EXsusY34hZP
gwLeEZ/iyUNUC3HcA0X8pfz/sYxl9Jv2DVkwm6pWQVXjv3Dugf25k2BnYBNLMMSb
geZWihfxxKOXrcEKmcZycM3ZyH3Udf+INZADP0HqnI2wFNV8HTB5ZKwQ4EvJVOub
IuEkY3tb6zQYu8UwbPzLzDZHMWMmRJ7CdoxD/QoD2nsMYekXQ7G1e9YmVnuJVen2
N2cRl8gOO4Y=
=Ni7C
-----END PGP SIGNATURE-----
