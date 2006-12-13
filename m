Return-Path: <linux-kernel-owner+w=401wt.eu-S932653AbWLMKlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWLMKlN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWLMKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:41:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:18270 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653AbWLMKlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:41:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NmnQqk7f/JB9EH6n/ELevunDG6HXg6c5To9vv9/R32cPAp9eKhoSa6GdmWnR42FPJx98XyKnZwN4wr2oyQdIkc2r+Ht+WYqlThLlVnv+3gyebrf/htqACiwITvoWvAPApkK/YArwdRMQi105Zkf4ThaBO0frZCMdj/bZ3CoEH6E=
Message-ID: <86802c440612130241i21a0cf25k14aaf2a145c094c6@mail.gmail.com>
Date: Wed, 13 Dec 2006 02:41:10 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Cc: "Greg KH" <gregkh@suse.de>, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
In-Reply-To: <86802c440612130209r5fab0de7q5dcda00c6c01cd13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
	 <m17ix24ywj.fsf@ebiederm.dsl.xmission.com>
	 <86802c440612080053s13e5318eq7ae83aff4c7eb21c@mail.gmail.com>
	 <m1zm9y3gd2.fsf@ebiederm.dsl.xmission.com>
	 <86802c440612122300k36e84f96x85ef25ebbf27077d@mail.gmail.com>
	 <m164cgqmmq.fsf@ebiederm.dsl.xmission.com>
	 <86802c440612130209r5fab0de7q5dcda00c6c01cd13@mail.gmail.com>
X-Google-Sender-Auth: 70ed50b266790c0c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_level4_pgt need to be updated in addtion to boot_level4_pgt?

also comment could be updated for good unstanding too.

YH
