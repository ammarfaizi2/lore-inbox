Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVFGFHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVFGFHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVFGFHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:07:43 -0400
Received: from opersys.com ([64.40.108.71]:15366 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261553AbVFGFHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:07:31 -0400
Message-ID: <42A52E15.7020801@opersys.com>
Date: Tue, 07 Jun 2005 01:18:13 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Anyone got a functional Asus K8N-DL?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a dual-opteron system here based on an Asus K8N-DL and I
just can't any of the Fedoras to install on it (FC3 outright freezes
on the loading of sata_nv and FC4-test3 doesn't freeze, but it just
stays there hung on the loading of sata_nv.) From browsing around,
apparently most people running into this kind of problem simply
plug all their HDs into the Silicon Image RAID controller instead
of the nVidia ck804. I'll do that if I must, but I'd really like
to get around running the thing with the ck804.

Has anybody been able to install any distro on this mobo with a
sata connected to the ck804, and if so which?

Any recommendations welcomed.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
