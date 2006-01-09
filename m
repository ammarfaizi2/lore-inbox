Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWAIKLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWAIKLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 05:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWAIKLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 05:11:22 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:32919 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751229AbWAIKLV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 05:11:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UuF6pYCZyAxTf8CccMeZ3HD9T/jXu3gCxMcA6BiEoKpr8EjOJDiGckC0EUCQkEWdoTuJ3enk6vKCUNjcPCcMuDEYxwnA+RoTRll+L15Ooyypm0kQQoqSz7kfG5DyAGe5tbQ/dHbfLBS6kOtMYz39pzaeKy/QjIoe1eHdKidwvn4=
Message-ID: <46a038f90601090211j33479764q13c74df60033a061@mail.gmail.com>
Date: Mon, 9 Jan 2006 23:11:20 +1300
From: Martin Langhoff <martin.langhoff@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: git pull on Linux/ACPI release tree
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       git@vger.kernel.org
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A136FE@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136FE@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Brown, Len <len.brown@intel.com> wrote:
> I appologize for using the phrase "completely insane".
> The rebase proposal caught me somewhat off-guard and
> I was expressing surprise -- hopefully not taken as insult.
>
> Further, I thank you for your thoughful follow-up.

No worries... and no offence taken! In a sense we are still exploring
possible/desirable workflows and what the missing pieces are. And yes,
some thing don't quite make sense from the outside, perhaps because
they just don't or because we arent' explaining them very well.

In a sense, we do have a bit of a challenge explaining what how all
the parts fit together, even to bk old timers it seems.

> While I don't expect it to become a routine occurnece for me,
> I do see that rebase has utility in some situations.

As long as you've got enough tools to use a workflow that fits you,
it's all good.

cheers,


martin
