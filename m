Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314629AbSDTOYi>; Sat, 20 Apr 2002 10:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314631AbSDTOYh>; Sat, 20 Apr 2002 10:24:37 -0400
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:51662 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314629AbSDTOYg>; Sat, 20 Apr 2002 10:24:36 -0400
Message-ID: <3CC17A1D.20901@ngforever.de>
Date: Sat, 20 Apr 2002 08:24:29 -0600
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.9+) Gecko/20020405
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
CC: Christian Schoenebeck <christian.schoenebeck@epost.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: power off (again)
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <1019163766.6743.8.camel@aurora>
Content-Type: multipart/mixed;
 boundary="------------010601090103070308090000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601090103070308090000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Trever L. Adams wrote:
> I can't remember where you make this change on RedHat

Should be /etc/rc.d/init.d/halt. See appended patch.

Regards,
Thunder
-- 
                                                   Thunder from the hill.
Not a citizen of any town.                   Not a citizen of any state.
Not a citizen of any country.               Not a citizen of any planet.
                          Citizen of our universe.

--------------010601090103070308090000
Content-Type: text/plain;
 name="halt.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="halt.diff"

LS0tIC9ldGMvcmMuZC9pbml0LmQvaGFsdAlNb24gTWFyIDE4IDA2OjI3OjM3IDIwMDIKKysr
IC9ldGMvcmMuZC9pbml0LmQvaGFsdH4JU2F0IEFwciAyMCAwODoyMDowMCAyMDAyCkBAIC0y
MzQsMyArMjM0LDMgQEAKIAotSEFMVEFSR1M9Ii1pIC1kIC1wIgorSEFMVEFSR1M9Ii1pIC1k
IgogaWYgWyAtZiAvaGFsdCBdOyB0aGVuCg==
--------------010601090103070308090000--

