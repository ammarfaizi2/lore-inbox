Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272684AbRHaMwr>; Fri, 31 Aug 2001 08:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272683AbRHaMwh>; Fri, 31 Aug 2001 08:52:37 -0400
Received: from mail.netcis.com ([199.227.10.105]:52177 "HELO pop1.netcis.com")
	by vger.kernel.org with SMTP id <S272682AbRHaMw2>;
	Fri, 31 Aug 2001 08:52:28 -0400
Date: Fri, 31 Aug 2001 08:46:46 -0700
From: Jeremiah Johnson <miah@netcis.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: Jeremiah Johnson <miah@netcis.com>
Organization: NETCIS International Corporation
X-Priority: 3 (Normal)
Message-ID: <67111542696.20010831084646@netcis.com>
To: Steve Kieu <haiquy@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.4.9 UDP broke?
In-Reply-To: <20010831055008.21675.qmail@web10404.mail.yahoo.com>
In-Reply-To: <20010831055008.21675.qmail@web10404.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: MD5

Hello Steve,

Thursday, August 30, 2001, 10:50:08 PM, you wrote:

SK>  --- Jeremiah Johnson <miah@netcis.com> wrote: >
SK> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: MD5
>>
>> Hello linux-kernel,
>>
>>   I am having very strange problems with 2.4.9 and
>> UDP.  Basically,
>>   anything using UDP wont work.  Anything using
>> TCP/ICMP works fine.

SK> May be it is not the kernel, I dont know but in my box
SK> it works as normal

SK> (I can use speakfreely ; it uses UDP and otehr program
SK> too)

Well considering the only thing I changed in my configuration is the
kernel, I think its a problem there.  Went from 2.4.3-ac? to 2.4.9.
System is RedHat 7.1.. Maybe it has something to do with RedHats
inclusion of a broken compiler, I'll have to check on that when I get
into the office.

I do have 2.4.9 working fine on other systems too.  Strange.
- --
Best regards,
 Jeremiah                            mailto:miah@netcis.com

-----BEGIN PGP SIGNATURE-----
Version: 2.6

iQEVAwUAO4+xapHTj7BlqKb5AQE/sQf+MNVYf4Dv4KRS2V3jiexwdlwpAUyNGUDp
VUli3po/IuoBsiz0zubCK0tFSVMB/2o24kYzAFIBKajrQP7uVVSUqbQzWpwWazpg
Vu3wAnHx3oPBpWmF3fxrMGjC/1g4FKUAnmBKne8VQOPaEVy+iUxZy5VQhXYXoBs0
O98+7VzgxjPI7txEmmqcJdLJHy7hQSuKvN9+FYvDmueeWeZV909NuH9P3Estp00c
HtuKAb57wkea8CcoZlknr+Iuei7geRAti4iGrGMYEVFNTYQxVVSC/FGM+T4UP1ia
R08TX47WHR2sucVatXv8oT/ixyepo82D0xIHbBltYLB8yqC/JxkDYA==
=5GKB
-----END PGP SIGNATURE-----

