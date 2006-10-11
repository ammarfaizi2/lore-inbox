Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030678AbWJKHlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbWJKHlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbWJKHlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:41:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:26776 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030678AbWJKHlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=k/fMe/A9VodJWwT3dJCg2Zg7a2rPvck+iDdPsOuOxmKBesaDDB1v6EZN0/k9HVNglqOSiAONHTmXDHSWE6L4UPxvsPODKcLviwYB9rejJH92rL2L/sX9OTfDkyqyxd+FYFuJm3UZ0iHIfTnkAv4DUcBpbLyMDMtXQooDkEtA6vo=
Message-ID: <84144f020610110041r26d632c9r6f120d8fb583599e@mail.gmail.com>
Date: Wed, 11 Oct 2006 10:41:05 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] ext3: fsid for statvfs
Cc: "Bryan Henderson" <hbryan@us.ibm.com>, "Andries Brouwer" <aebr@win.tue.nl>,
       "H. Peter Anvin" <hpa@zytor.com>, sct@redhat.com, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20061010133636.6217a11b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610101131001.10574@sbz-30.cs.Helsinki.FI>
	 <20061010133636.6217a11b.akpm@osdl.org>
X-Google-Sender-Auth: 544f73eebc582e6d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> ext2 and ext4 would need patching too...

I see you already beat me to it. Thanks Andrew!

                           Pekka
