Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbRK2PSF>; Thu, 29 Nov 2001 10:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283270AbRK2PRz>; Thu, 29 Nov 2001 10:17:55 -0500
Received: from mail.reutershealth.com ([204.243.9.36]:33177 "EHLO
	mail.reutershealth.com") by vger.kernel.org with ESMTP
	id <S283266AbRK2PRj>; Thu, 29 Nov 2001 10:17:39 -0500
Message-ID: <3C0651E5.10908@reutershealth.com>
Date: Thu, 29 Nov 2001 10:19:01 -0500
From: John Cowan <jcowan@reutershealth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML 1.9.2 is available
In-Reply-To: <20011129060048.A11216@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:


> Keith has pointed out a weakness in the language -- there's no way to make
> the default value of a choices menu dependent on the architecture (an issue
> for things like kcore format).  I am meditating on this.


Suggestion: allow a derived symbol as the default.  It must be possible
to prove that the value of this symbol is going to be one of the
choices.

-- 
Not to perambulate             || John Cowan <jcowan@reutershealth.com>
    the corridors               || http://www.reutershealth.com
during the hours of repose     || http://www.ccil.org/~cowan
    in the boots of ascension.  \\ Sign in Austrian ski-resort hotel

