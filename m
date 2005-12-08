Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVLHTJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVLHTJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVLHTJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:09:27 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:48626 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932255AbVLHTJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:09:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=eQ2s2dQ/HUt5b6UKV+Ty9cYTm5QhS2jNMMzrgg7wCRfWO1HEpHmt6QjF14Um5xtfo3lucbrkILWjvJ3WdsLcTkraeLReksPTOKylfQXQCGnKFNEZW/rKWAahmwrlHvAKGqPdrhmiLmEjf39QYk3imZizqpYO+XcLU+r7HMojiAk=
Subject: Re: 2.6.15-rc5-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
References: <20051204232153.258cd554.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 11:09:43 -0800
Message-Id: <1134068983.21841.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 23:21 -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/

In file included from sound/pci/ens1371.c:2:
sound/pci/ens1370.c: In function `snd_audiopci_probe':
sound/pci/ens1370.c:2462: error: `spdif' undeclared (first use in this
function)sound/pci/ens1370.c:2462: error: (Each undeclared identifier is
reported only once
sound/pci/ens1370.c:2462: error: for each function it appears in.)
sound/pci/ens1370.c:2462: error: `lineio' undeclared (first use in this
function)
make[2]: *** [sound/pci/ens1371.o] Error 1
make[2]: *** Waiting for unfinished jobs....


Thanks,
Badari

