Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154716-8088>; Thu, 17 Sep 1998 04:43:16 -0400
Received: from ceylon.informatik.uni-rostock.de ([139.30.5.237]:4894 "EHLO ceylon.informatik.uni-rostock.de" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154835-8088>; Thu, 17 Sep 1998 04:32:07 -0400
Message-ID: <19980917135106.A18791@honshu.informatik.uni-rostock.de>
Date: Thu, 17 Sep 1998 13:51:07 +0200
From: Jan Echternach <echter@informatik.uni-rostock.de>
To: linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
Reply-To: Jan Echternach <jan.echternach@informatik.uni-rostock.de>
Mail-Followup-To: linux-kernel@vger.rutgers.edu
References: <19980914165757.A17479@tantalophile.demon.co.uk> <199809150603.XAA29073@cesium.transmeta.com> <19980915100729.02790@albireo.ucw.cz> <35FF1838.6E247F0C@his.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <35FF1838.6E247F0C@his.com>; from David Feuer on Tue, Sep 15, 1998 at 09:45:28PM -0400
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Sep 15, 1998 at 09:45:28PM -0400, David Feuer wrote:
> In my opinion, the thing to do is make the POSIX time function do
> something fairly reasonable, but come up with something better (e.g. UTC
> and TAI in 64 or 128-bit fixed-point format) for newer programs.

There is a similar discussion going on in comp.std.c (Subject: C9X FCD -
7.23.2.6 Normalization of broken-down times).

See also http://www.cl.cam.ac.uk/~mgk25/c-time/ for a proposal for a
new time API.

-- 
Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
