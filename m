Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290597AbSAYIES>; Fri, 25 Jan 2002 03:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290508AbSAYIEI>; Fri, 25 Jan 2002 03:04:08 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:35042
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S290597AbSAYIDz>; Fri, 25 Jan 2002 03:03:55 -0500
Message-ID: <3C511163.7030500@debian.org>
Date: Fri, 25 Jan 2002 09:03:47 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] kernelconf-0.1.2
In-Reply-To: <fa.fntpj9v.103mb83@ifi.uio.no> <fa.h5to74v.132gv1k@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> On Thu, Jan 24, 2002 at 12:45:48PM +0600, Anuradha Ratnaweera wrote:
> 
>>Here we go again...
>>
>>Version 0.1.2 is an RFC.  Don't use it unless you are really adventurous.
>>The size of the tarball has grown by a factor of 6, mostly due to the
>>symbol files.
>>
> 
> Hi Anuradha.
> I have not looked into the SRC, but IIRC you mentioned an interest in LEX/YACC for CML2.
> Take a look at:
> http://www.alphalink.com.au/~gnb/cml2
> 
> This is an incomplete implementation of a CML2 parser + semantic analysis in C utilising a bison parser.


Hmm. This is the 3rd C cml2 implementation I have heard. (+ non CML2 based Kernelconfig).


People, don't waste the time! Please merge the projects (They will be only one).

	giacomo


PS: THe other projects are in sourceforge: one subproject in 'kbuild', and the
other is 'cml2config'.

