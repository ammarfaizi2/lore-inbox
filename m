Return-Path: <linux-kernel-owner+w=401wt.eu-S1751508AbWLOLDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWLOLDJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 06:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWLOLDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 06:03:09 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:3887 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbWLOLDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 06:03:08 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 06:03:07 EST
Date: Fri, 15 Dec 2006 11:56:50 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: "Giacomo A. Catenazzi" <cate@cateee.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Postgrey experiment at VGER
Message-ID: <20061215105649.GE3391@vanheusden.com>
References: <200612131711.28292.a1426z@gawab.com> <458025A5.2070001@cateee.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458025A5.2070001@cateee.net>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Fri Dec 15 23:58:44 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>May I suggest a smarter way to filter these spammers, by just whitelisting 
>email addresses of valid posters, after sending a confirmation for the 
>first post.  Now if these spammers get smart, and start using personal 
>email addresses, I would certainly expect some real action by abused email 
>address owners.

Spammers will fake the from-address, possibly using the address of a
spam-trap for the from-field. Your challenge will then be sent to the
spam-trap, causing vger to be blacklisted.


Folkert van Heusden

-- 
Temperature outside:    8.562500, temperature livingroom: 21.4
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
