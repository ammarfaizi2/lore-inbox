Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWB0Upp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWB0Upp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWB0Upp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:45:45 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:20761 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964798AbWB0Upo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:45:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UNR+z9l3KMl5Br55BbsPmtOITou9ESzh1bRg8DwicyEdAtlFFKavwp5mHoVFe/VAyBDCsaRvS+jlsHYi2Hljdjt1YlRZXZ2FIus+dffzJB3Q65SYfZKdKzywLq/Erzg4dH5dLV9M0rsciPEF++c1oew8AqXQ+Ay/yy3eXdpfTrE=
Message-ID: <9a8748490602271245w71406a56qaf808ca622240f82@mail.gmail.com>
Date: Mon, 27 Feb 2006 21:45:43 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Hans Reiser" <reiser@namesys.com>
Subject: Re: creating live virtual files by concatenation
Cc: "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>,
       "Rik van Riel" <riel@redhat.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <44036391.6040305@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1271316508.20060225153749@dns.toxicfilms.tv>
	 <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com>
	 <612760535.20060225181521@dns.toxicfilms.tv>
	 <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com>
	 <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com>
	 <1391154345.20060225203352@dns.toxicfilms.tv>
	 <44036391.6040305@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/06, Hans Reiser <reiser@namesys.com> wrote:
> Pretty much any simple basic tool or extension can be lived without.
> For them to say that you can do without it is to say nothing.  There is

All I said was that I don't *think* it will be of much use, that's not
to say that it *won't* be.

As a read-only thing I can certainly see some uses of it - Maciej
pointed out some nice ideas, sure, but wether or not they are actually
useful when you try to do real work needs to be tested. I for one need
to see it and play with it to determine if it will actually be useful.

Let's see an implementation and see how it works out for real...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
