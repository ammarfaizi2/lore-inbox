Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129490AbRBTWzM>; Tue, 20 Feb 2001 17:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbRBTWzE>; Tue, 20 Feb 2001 17:55:04 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:3082 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S129490AbRBTWyd>; Tue, 20 Feb 2001 17:54:33 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: <E14V1Xa-0005Bf-00@the-village.bc.nu>
	<200102200211.f1K2BO002802@konerding.com>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 21 Feb 2001 09:54:19 +1100
In-Reply-To: dek_ml@konerding.com's message of "20 Feb 01 02:11:23 GMT"
Message-ID: <84ae7hge3o.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "dek" == dek ml <dek_ml@konerding.com> writes:

    dek> OK so I think what I can take from this is: for kernel 2.4 in
    dek> the foreseeable future, reiserfs over NFS won't work without
    dek> a special patch.  And, filesystems other than ext2 in general

Does this apply to the user space NFS server? kernel space NFS server?
Or both?
-- 
Brian May <bam@snoopy.apana.org.au>
