Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVFROpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVFROpD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVFROpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:45:03 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:51309 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262127AbVFROo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:44:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FEcVffthIzDrt4NJKfkcAdpyeE/iz+SUBRhFFM5028LBO8T/UBzC8L8s8dDqs5W47EJnXfdeaErmgxCpm8vBe0+RQbKwwP0b1EX6Tnd/IMcP6lQdqy0J0wq6VrY7QG448JfjHh5ZSL33/MljKj3bKIL4nnDoCy0p4KS3/HupAwM=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kernel bugzilla
Date: Sat, 18 Jun 2005 18:50:33 +0400
User-Agent: KMail/1.7.2
Cc: Jens Axboe <axboe@suse.de>, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
References: <20050617001330.294950ac.akpm@osdl.org> <20050617212338.GA16852@suse.de> <20050617143946.00f387d0.akpm@osdl.org>
In-Reply-To: <20050617143946.00f387d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181850.35381.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 01:39, Andrew Morton wrote:
> We should encourage people to use bugzilla as the initial
> entry-point.  But if someone instead uses email as the first contact I'm
> just a little bit reluctant to say "thanks, now go and try again".
> 
> Perhaps we could find some nice volunteer (hint) who could take the task of
> transferring such reports into bugzilla.

Andrew, I'm going to file

	Subject: 2.6.12: connection tracking broken?
	Subject: 2.6.12 cpu-freq conservative governor problem
	Subject: PROBLEM: libata + sata_sil on sil3112 dosen't work proper
	Subject: [2.6.12] x86-64 IO-APIC + timer doesn't work

around monday evening if there would be no activity.

Do I understand correctly that the procedure is

	1. Search for duplicates
	2. Choose category
	3. Add "From: Joe Reporter <>" at the beginning, copy-paste email.
	4. Add Joe and relevant lists to CC.
	5. Profi^WCommit

and bugzilla won't shoot unsuspecting guys afterwards?
