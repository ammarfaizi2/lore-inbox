Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTEIVLg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263465AbTEIVLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:11:36 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:36762 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263464AbTEIVLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:11:33 -0400
Date: Fri, 9 May 2003 17:22:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Adding an "acceptable" interface to the Linux kernel for
  AFS
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       openafs-devel@openafs.org, David Howells <dhowells@redhat.com>
Message-ID: <200305091723_MC3-1-3834-B647@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>> I assume:
>> fs is a text representation of whose filesystem you're doing this for?
>> ("openafs", "arla", etc)
>> domain is what's typically referred to as an afs cell
>
> Yes. After all, you might need the key to be available before you can mount.
>
> This may be useful for samba too... The mount command for samba typically
> requires authentication data to be passed as options (workgroup, username,
> password).

  ncpmount, too?

  Petr Vandrovec is listed as maintainer...
