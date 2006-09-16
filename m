Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWIPBBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWIPBBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 21:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWIPBBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 21:01:47 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:17684 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750754AbWIPBBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 21:01:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IM1lITLbObhpWVFHuH65W2WZ8G/tXRwxLZROL591mb9pEPNQccidEXXGpo3OgzAUfrI88gVMFTOEA0sB58HnuLEb+ERL/XnzmVnkqRq3ljo1YlqYFEyXgI6DZ+iYYg+5T46pJOL2Caxn0LnxM/Hw5Ugw6Tjy0ow/Cmqtf05vCGs=
Message-ID: <653402b90609151801n4b02fae1y763707f139c9818d@mail.gmail.com>
Date: Sat, 16 Sep 2006 03:01:45 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: jim@gibbons.com
Subject: Re: request for ioctl range for private devices
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <450B48CC.6060604@gibbons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <450B31BF.4050604@gibbons.com>
	 <653402b90609151726l230e9bafg5d06a36e7cd7b32c@mail.gmail.com>
	 <450B48CC.6060604@gibbons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/06, Jim Gibbons <jim@gibbons.com> wrote:
>
> We do think that such embedded use might be common, though,
> and we would like to see a range of ioctls reserved for private and
> experimental uses like ours.
>

Sorry, I tought you were asking for a ioctl range just for you.

It seems fair to me to have a private ioctl range where anyone should
use anytime in the future, just for tests and private use. Althought,
I can't help you too much with that, you will have to wait to the true
maintainers, I was just trying to give you ideas comparing it to my
case and which approach I would take.

Just wait until someone more useful answer you :)
