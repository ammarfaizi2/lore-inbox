Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbQKJKta>; Fri, 10 Nov 2000 05:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbQKJKtU>; Fri, 10 Nov 2000 05:49:20 -0500
Received: from web1101.mail.yahoo.com ([128.11.23.121]:10244 "HELO
	web1101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129322AbQKJKtP>; Fri, 10 Nov 2000 05:49:15 -0500
Message-ID: <20001110104909.7345.qmail@web1101.mail.yahoo.com>
Date: Fri, 10 Nov 2000 11:49:09 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: Linux 2.2.18pre21
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-861021530-973853349=:7091"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-861021530-973853349=:7091
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

> > >         is important.  We could call it
ETHERNETCHANNEL (and even
> > >         "Etherchannel" or "ETHERCHANNEL") get
away with it clean.
> > > ...
> > > /Matti Aarnio
 
> 	Anything but "EtherChannel" -- trademark people 


Ok, Matti. Let's keep "Etherchannel" as you proposed
and as it was documented in the Configure.help. This
patch fixes it (I won't resend the complete patch
on the LKML because 20kB is generally to big for
unconcerned people).

Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
--0-861021530-973853349=:7091
Content-Type: application/x-unknown; name="etherchannel-spelling-fix.diff.gz"
Content-Transfer-Encoding: base64
Content-Description: etherchannel-spelling-fix.diff.gz
Content-Disposition: attachment; filename="etherchannel-spelling-fix.diff.gz"

H4sIAGXSCzoCA61V247bNhB9tr5ikCc7uthyN92uURROsmlrYJsWsIFFH2lp
ZBGmSIUXX/6+Q0pyvem22TY1DNkUOYfDM3MOS15VkDr9EQSX7pTOs3mWf9fO
83irZMnlbnqvCtegtMxyJacS7VHpvZ/oF2T2ZP8uOC5VUfHTizCiNE2/KonR
j5rDR3WAfAZ5vpjPF/kdzGezWRTH8f+R4Wcb3NwubmbdBsslpPM8T24h7n6W
ywgiGK0kaOVkmWq15RIaVWIC3IIHN3DktgZzNhYbA7ZmFoxrW6UtWO2k331B
GFE6eg3vuSkUvHkzm4FBzdHAWCi1h0pp+GBr1O9rJiWKAWGSRfFLwoq/hAGF
rZ3c9BmAUZU9Mo3dzFthUUl4W+A911hYwjF0jKIm6Ck84vbXNYydQQjxpsd7
x85ry4o9rIe143BCA40zFrYIeGoFL7gVZyiUrPjOaSwnGYQwthUYKP5mFiju
fjzF6b/9RLCywD3btCczxAiRrYgcC64FJks/ooKhNpZGlABv2uukfGQEGhtl
CeGT463vGhjXipAubEw8DNvtNO4YrbOaVRUvQB2QViA9mYhST/jARAJ4VQ4/
KrJJyOfJztB3I3BpUVesQEOF7oE2HdCH/wwEqyrMUZs6gVAzQ6VBCUKxEsuu
Xf18q1VLB/lltQLVer10Pc2FCI0dAXNWNaSkgglxzuB35aBg0sfSQ589OZ7B
A4bENBVBUVolWRFqzyZpdW+iMGkQKUc4K6cpjx2JxuvEZ1Fq7uks0VIfmgwe
Azph0bESHwANO0flF/2twzFe8xexF1+yi2eD/tHBno34Kst6CSJ51Cz/06Nu
Enodh6eXD5BDqPas+a62kN/d3SWwqalyBu7ZgZsELCv9n6XYimynDhlACHrg
BUpDLRGUEqrx028PGencvyR/KF3TnLMiCSXET4IILfHAuy6D11FKIJeUF8CG
wfRaBVPj5MUJgU7ZlzyKP49+10dft/6UTAw2z0T7/f0hNjX5AH3JrSonfE9a
JvZBuFe+mQBBSA/xVFdszxb+GKMHXyQY7LfPxKfYzwxvaMvRk5TGayWY5mZy
yehndbxcDotQr9s8+Rbi28HuaE33CSLQ6OXV3yVkPVLZwG4o9zTPp1T5FB65
X7RhmpY7+P4YhhTdoGXpKVN698MFOAXqK6pgxcn+wAhGCiXUp3r2hJVek6E0
4U7LQkmGbam5FmBaFMIfU1Xw6pq6V2RE2l8dWGbDyad0Wf4BQgThfIkIAAA=


--0-861021530-973853349=:7091--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
