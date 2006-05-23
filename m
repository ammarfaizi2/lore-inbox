Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWEWOBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWEWOBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWEWOBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:01:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:1568 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751042AbWEWOBd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:01:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SLJQFOZ8VpfZBcaVgRkJs6lL0eCdgc+KKjbHxk+DnFLgqEWTE6yDNVniOag9J15SJ1i4ClLj0gcDhCjKhuuAFXIy65aJAI9Hzmhh1VgSglIu07MlNftpLhetJtNqEcZp6RjvQ/4Dkw33hnO93ty3Ok2t2TsIfcU5q/IOAqCZLHk=
Message-ID: <756b48450605230701l5f0556adwe9c4c3397e97d9bd@mail.gmail.com>
Date: Tue, 23 May 2006 10:01:32 -0400
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v2
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD11206E4@pdsmsx411.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <554C5F4C5BA7384EB2B412FD46A3BAD11206E4@pdsmsx411.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, Yu, Luming <luming.yu@intel.com> wrote:
> >http://marc.theaimsgroup.com/?l=linux-acpi&m=114308645502914&w=2
> >
> >After that I didn't do anything further and I guess nothing further
> >happened with that. Then I noticed Matthew Garrett's patch adding
> >input support to the acpi button driver.
>
> Ok, I will push them into mm tree.
>

I assume you mean you are going to push the hotkey patch. Not the
atlas patch. Andrew applied the v4 patch of atlas acpi to -mm already.

jaya
