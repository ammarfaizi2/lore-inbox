Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYIAj>; Sat, 25 Nov 2000 03:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQKYIA3>; Sat, 25 Nov 2000 03:00:29 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:19515 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S129153AbQKYIAR>; Sat, 25 Nov 2000 03:00:17 -0500
Message-ID: <3A1F6A7A.440C9933@linux.com>
Date: Fri, 24 Nov 2000 23:30:03 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Charles Peterman <peterman@eecs.tufts.edu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: CS4630
In-Reply-To: <Pine.GSO.4.05.10011250018140.28185-100000@andante.eecs.tufts.edu>
Content-Type: multipart/mixed;
 boundary="------------1ACF5BF5E6F76BCF938E4FF9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1ACF5BF5E6F76BCF938E4FF9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Charles Peterman wrote:

> Thanks, I had to putz with the gain to get sound out of it without
> turning my amp to 11, but yes it works.  Do you know if anyone is
> putting in the effort to make the six channel useful?
>
> Thanks again,

Dunno about that, I use gmix for my mixer and it sounds fine, I did note that you
can't use non-powered speakers with it, the sound is awfully low.  If you use
powered speakers or pipe it out to an amp, it is perfect sounding.  That is the
only hardware issue I have.

There is also an issue with the line in, the line in level is zero unless PCM
sound is being played.  So you need to play mp3s but mute PCM in order to listen
to other inputs.

-d


--------------1ACF5BF5E6F76BCF938E4FF9
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------1ACF5BF5E6F76BCF938E4FF9--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
