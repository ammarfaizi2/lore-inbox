Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288102AbSAVC3K>; Mon, 21 Jan 2002 21:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289116AbSAVC3B>; Mon, 21 Jan 2002 21:29:01 -0500
Received: from ccs.covici.com ([209.249.181.196]:11392 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S288102AbSAVC2w>;
	Mon, 21 Jan 2002 21:28:52 -0500
To: emacs-devel@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: reading a file in emacs crashes 2.4.17 and 18-pre4
From: John Covici <covici@ccs.covici.com>
Date: Mon, 21 Jan 2002 21:28:47 -0500
Message-ID: <m38zardsps.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Its a small file and was actually an accident, but you get all sorts
of unable to handle kernel paging ... and eventually a kernel panic
because it was trying to kill the idle process.

I am using emacs version "21.2.50.1" and I have 1.4ghz Athlon and 256
m of memory.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=vt100
Content-Transfer-Encoding: base64

GgEsABUABwAOAf8BdnQxMDB8dnQxMDAtYW18ZGVjIHZ0MTAwICh3L2FkdmFuY2VkIHZpZGVvKQAA
AQAAAQAAAAAAAAAAAAEAAAAAAAEAUAAIABgA////////AwD//wAAAgAEABUAGgAmAC4A/////zcA
TABOAP//UgD/////VAD//1wA/////////////2QAZgBvAP///////////////3gAgQCKAP//kwCV
AP///////54ApgD//////////////////////////64A/////////////7AA////////tAC4ALwA
wADEAMgAzADQANQA2ADcAP///////+AA////////5AD////////oAOwA9AD/////////////////
/////////////////////////////AD///////8FAQ4B//8XAf////////////////////8gAf//
//88Af//PwFCAUQBSwGTAf//lgH//////////5gBnAGgAaQBqAH/////rAH//////////98B5QH/
////6wH////////////////////////yAf//////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////9gEHAA0AG1slaSVwMSVkOyVwMiVkcgAbWzNnABtbSBtbSiQ8NTA+ABtbSyQ8Mz4AG1tKJDw1
MD4AG1slaSVwMSVkOyVwMiVkSCQ8NT4ACgAbW0gACAAbW0MkPDI+ABtbQSQ8Mj4ADgAbWzVtJDwy
PgAbWzFtJDwyPgAbWzdtJDwyPgAbWzdtJDwyPgAbWzRtJDwyPgAPABtbbQ8kPDI+ABtbbSQ8Mj4A
G1ttJDwyPgAIABtPQgAbT3kAG09QABtPeAAbT1EAG09SABtPUwAbT3QAG091ABtPdgAbT2wAG093
ABtPRAAbT0MAG09BABtbPzFsGz4AG1s/MWgbPQAbWyVwMSVkQgAbWyVwMSVkRAAbWyVwMSVkQwAb
WyVwMSVkQQAbPhtbPzNsG1s/NGwbWz81bBtbPzdoG1s/OGgAGzgAGzcACgAbTSQ8NT4AG1swJT8l
cDElcDYlfCV0OzElOyU/JXAyJXQ7NCU7JT8lcDElcDMlfCV0OzclOyU/JXA0JXQ7NSU7bSU/JXA5
JXQOJWUPJTsAG0gACQAbT3EAG09zABtPcgAbT3AAG09uAGBgYWFmZmdnampra2xsbW1ubm9vcHBx
cXJyc3N0dHV1dnZ3d3h4eXl6ent7fHx9fX5+ABtbPzdoABtbPzdsABsoQhspMAAbT00AG1sxSyQ8
Mz4A
--=-=-=


-- 
         John Covici
         covici@ccs.covici.com

--=-=-=--
