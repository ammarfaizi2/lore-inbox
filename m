Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVBUPjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVBUPjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVBUPjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:39:51 -0500
Received: from smtpout01-04.mesa1.secureserver.net ([64.202.165.79]:37783 "HELO
	smtpout01-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S262013AbVBUPju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:39:50 -0500
Message-ID: <421A00D2.4030101@starnetworks.us>
Date: Mon, 21 Feb 2005 08:40:02 -0700
From: "Kevin P. Fleming" <kpfleming@starnetworks.us>
Organization: Star Networks, LLC
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Miles Bader <miles@gnu.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Sean <seanlkml@sympatico.ca>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Chris Friesen <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <seanlkml@sympatico.ca> <20050218162729.GA5839@thunk.org> <buomzty5uyw.fsf@mctpc71.ucom.lsi.nec.co.jp> <200502210156.47993.dtor_core@ameritech.net>
In-Reply-To: <200502210156.47993.dtor_core@ameritech.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

> It's not too bad as you just hardlink most of the trees to their parent.

Yes, and disk space is cheap.

> I think there is a setting to have them checked out for editing automatically.

Yes there is, plus most decent editors are SCCS-aware and will prompt 
for a checkout when you try edit a locked file anyway (emacs certainly 
does, without any add-on modules).
