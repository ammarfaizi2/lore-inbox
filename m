Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129754AbRCASV4>; Thu, 1 Mar 2001 13:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129758AbRCASVq>; Thu, 1 Mar 2001 13:21:46 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:19586 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S129754AbRCASVh> convert rfc822-to-8bit; Thu, 1 Mar 2001 13:21:37 -0500
Date: Thu, 1 Mar 2001 19:21:29 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Sébastien HINDERER <jrf3@wanadoo.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Escape sequences & console
In-Reply-To: <"3a9e8dcd3b72e6a5@amyris.wanadoo.fr> (added by amyris.wanadoo.fr)">
Message-Id: <Pine.LNX.4.31.0103011919490.23240-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Sébastien HINDERER wrote:

> Could someone tell me where I can find a document listing all the
> escape-sequences that could be sent to the console (/dev/console) and what
> they do.

Please don't use those sequences directly, as not everyone has
/dev/console on a vt. You can find the information you want in your local
terminfo database under "linux".

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
NP: Inside Treatement - Klaustraph

