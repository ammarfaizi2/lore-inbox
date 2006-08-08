Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWHHPd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWHHPd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWHHPd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:33:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:57507 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964957AbWHHPd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:33:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hZH7rCgK8bZefEuHW+AY18yMsdx6XgN8pV1/JATmb7S0AQ7HZvAfMiGeebQKZGFtGiqem5Yw4JT/JsksVGniC061eYcFygEfHVRT1rVMba9l+jRbgRnzvVRJzh+Lf6jIRefE1VybxYSokYMYS6PR+/1u5kdgCKLt8OHDgKjcRMU=
Message-ID: <41840b750608080833p6e7cfffx890f9c4732b93e73@mail.gmail.com>
Date: Tue, 8 Aug 2006 18:33:25 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, "Pavel Machek" <pavel@suse.cz>,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <1155050380.5729.89.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
	 <20060807182047.GC26224@atjola.homenet>
	 <20060808122234.GD5497@rhun.haifa.ibm.com>
	 <20060808125652.GA5284@ucw.cz>
	 <20060808131724.GE5497@rhun.haifa.ibm.com>
	 <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com>
	 <20060808134337.GF5497@rhun.haifa.ibm.com>
	 <41840b750608080753v27a0ce16xf4da0ad177b08657@mail.gmail.com>
	 <1155050380.5729.89.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> If the concern is just the naming then change it to end _trylock

We already have a thinkpad_ec_trylock() for the non-blocking variant.

  Shem
