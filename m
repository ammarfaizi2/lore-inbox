Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTLKPOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTLKPOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:14:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:17870 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265105AbTLKPNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:13:41 -0500
Date: Thu, 11 Dec 2003 09:13:31 -0600
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Problems with NFS while running SpecSFS with JFS filesystem and 2.6 kernel.
Message-ID: <20031211151331.GA7920@dbz.austin.ibm.com>
References: <20031210144011.GE708@dbz.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031210144011.GE708@dbz.austin.ibm.com> (from jrsantos@austin.ibm.com on Wed, Dec 10, 2003 at 08:40:11 -0600)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/03 08:40:11, Jose R. Santos wrote:
>      >>>Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 00420051 00000002 0000a17e 00009083 00000000 file_en.46340
>      >>>Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 00420051 00000002 0000a17e 00009083 00000000 file_en.46410

I'm looking at the NFSd code and I think I'm getting a little confuse
and since I'm not a NFS expert, I don't know if something like the above
two lines is OK or not.

Can someone impose a bit of wisdom on me. :)

-JRS
