Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbTJOS5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTJOSzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:55:44 -0400
Received: from mail.midmaine.com ([66.252.32.202]:48057 "HELO
	mail.midmaine.com") by vger.kernel.org with SMTP id S264056AbTJOSys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:54:48 -0400
To: josh@temp123.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
X-Eric-Conspiracy: There Is No Conspiracy
References: <1066163449.4286.4.camel@Borogove>
	<20031015133305.GF24799@bitwizard.nl>
	<16269.20654.201680.390284@laputa.namesys.com>
	<20031015142738.GG24799@bitwizard.nl>
	<16269.23199.833564.163986@laputa.namesys.com>
	<20031015160430.GH24799@bitwizard.nl> <1066238667.836.4.camel@Borogove>
From: Erik Bourget <erik@midmaine.com>
Date: Wed, 15 Oct 2003 14:53:35 -0400
In-Reply-To: <1066238667.836.4.camel@Borogove> (Josh Litherland's message of
 "Wed, 15 Oct 2003 13:24:27 -0400")
Message-ID: <87u16a5o40.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Litherland <josh@temp123.org> writes:

> On Wed, 2003-10-15 at 12:04, Erik Mouw wrote:
>
>> FYI: you hardly see compressed files on NTFS. If you do, it's either
>> because the user thought it was a fun feature
>
> -shrug-  The windows disk cleanup tool does this by default now if you
> let it.  It compresses files that have an old access time.  Not a bad
> idea imo, if perhaps one of limited usefulness.

What happens when you go through and do a folder-open on that old directory of
pictures that you had, which re-reads them to generate thumbnails?  Do they
have to be uncompressed-on-disk to be read?  Will they stay compressed
forever, or be decompressed automatically on access?

- Erik Bourget

